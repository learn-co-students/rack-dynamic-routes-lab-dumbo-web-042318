class Application

    @@items = [Item.new("ice-cream", 3.99), Item.new("tacos", 1.99)]

    def call(env)
        resp = Rack::Response.new
        req = Rack::Request.new(env)

        if req.path.match(/items/)

            item_title = req.path.split("/items/").last

            item = @@items.find do |item_instance|
                item_instance.name == item_title
            end 

            item_instance = find_helper(@@items, item_title)

            if item_instance
                resp.status = 200
                resp.write "#{item_instance.name} cost #{item_instance.price}"
            else
                resp.status = 400
                resp.write "Item not found"
            end

        
        else

            resp.write "Route not found"
            resp.status = 404

        end 

        resp.finish

    end 

    def find_helper(item_collection, item_name)
        item_collection.find do |item_instance|
            item_instance.name == item_name
        end 
    end 

end 