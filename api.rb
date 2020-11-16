require 'grape'
require_relative 'store'

class API < Grape::API
  version 'v1'
  format :json
  resource :payment do
    params do
      requires :output, type: Integer
    end
    post do
      remain = params[:output]
      storage = Store.new
      sorted_store = Hash[storage.store.sort_by{|k,v| k}.reverse]
      output = {}
      sorted_store.each do |index, value|
        denomination = index.to_i
        if((remain >= denomination) && (value > 0))
          val = remain / denomination
          if val > value
            val = value
          end
          remain -= val * denomination
          output[index] = val
        end
      end
      if remain == 0
        storage.subtraction(output)
        { output: output}
      else
        available = storage.store.select{|k,v| v > 0}.keys.join(', ')
        storage.store.all?{|index, value| value == 0} ?
            {message: "There is no money in the ATM!"} :
            {message: "Selected amount not available, available denominations " + available}
      end
    end
  end

  resource :deposite do
    params do
      requires :input
    end
    post do
      input = params[:input]
      storage = Store.new
      storage.sum(input)
      {store: storage.store}
    end
  end
end