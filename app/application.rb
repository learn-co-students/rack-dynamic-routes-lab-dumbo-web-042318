class Application

  @@items = [Item.new("Apples",5.23), Item.new("Oranges",2.43)]

  def call(env)

    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if !req.path.match(/items/)

      resp.write "Route not found"
      resp.status = 404

    else req.path.match(/items/)

      item_name = req.path.split("/items/").last

      if item = @@items.find do |item|
        item.name == item_name
        end

      resp.write item.price

      else
        resp.write "Item not found"
        resp.status = 400
      end
    end

    resp.finish

  end

end


# We've provided a basic Item class. Let's get more information on our items.
#
# INSTRUCTIONS
# Your application should only accept the /items/<ITEM NAME> route. Everything else should 404
# If a user requests /items/<Item Name> it should return the price of that item
# IF a user requests an item that you don't have, then return a 400 and an error message
