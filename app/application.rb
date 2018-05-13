class Application

    @@items = []

    def call(env)
        resp = Rack::Response.new
        req = Rack::Request.new(env)

        if req.path.match(/items/)

            item_title = req.path.split("/items/").last

            item = @@items.find do |item_instance|
                item_instance.name == item_title
            end 

            if find_helper(@@items, item_title)
                item_instance = find_helper(@@items, item_title)
                resp.status = 200
                resp.write "#{item_instance.price}"
            else
                resp.write "Item not found"
                resp.status = 400
            end

        
        else

            resp.write "Route not found"
            resp.status = 404

        end 

        resp.finish

    end 

    def find_helper(item_collection, item_name)
        item_collection.find do |x|
            x.name == item_name
        end 
    end 

end 