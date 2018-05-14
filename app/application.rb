class Application
  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      item_name = req.path.split("/items/").last
      item = Item.all.find do |item|
        item.name == item_name
      end

      if item == nil
        resp.status = 400
        resp.write "Item not found"
      else
        resp.write item.price
      end

    else
      resp.status = 404
      resp.write "Route not found"
    end

    resp.finish
  end
end
