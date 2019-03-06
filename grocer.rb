require 'pry'
def consolidate_cart(cart)
  new_hash = {}
  cart.each do |item|
    item.each do |name, option_hash|
      if(new_hash[name] == nil)
        new_hash[name] = option_hash.merge({:count => 1})
      else
        new_hash[name][:count] += 1
      end
    end
  end
  new_hash
end


def apply_coupons(cart, coupons)
  #cart = {"AVOCADO"=>{:price=>3.0, :clearance=>true, :count=>2}}
  #coupons = [{:item=>"AVOCADO", :num=>2, :cost=>5.0}]
    coupons.each do |coupon_hash|
      item = coupon_hash[:item]
      new_coupon_hash = {
        :price => coupon_hash[:cost],
        :clearance => "true",
        :count => coupon_hash[:num]
      }

      if cart.key?(item)
        new_coupon_hash[:clearance] = cart[item][:clearance]
        if cart[item][:count] >= new_coupon_hash[:count]
          new_coupon_hash[:count] = (cart[item][:count]/new_coupon_hash[:count]).floor
          cart[item][:count] = (coupon_hash[:num])%(cart[item][:count])
        end
        cart[item + " W/COUPON"] = new_coupon_hash
      end
    end
    return cart
  end




def apply_clearance(cart)
  cart.each do |item, option_hash|
    if(option_hash[:clearance] == true)
      option_hash[:price] = (option_hash[:price] * 0.8).round(2)
    end
  end
  cart
end

def checkout(cart, coupons)
  # code here
end
