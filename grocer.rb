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
  #   #cart = {"AVOCADO"=>{:price=>3.0, :clearance=>true, :count=>2}}
  #   #coupons = [{:item=>"AVOCADO", :num=>2, :cost=>5.0}]

  return cart if coupons == []

  new_cart = cart

  coupons.each do |coupon|
    name = coupon[:item]
    num_of_coupon = coupon[:num]
    if cart.include?(name) && cart[name][:count] >= num_of_coupon
      new_cart[name][:count] -= num_of_coupon
      if new_cart["#{name} W/COUPON"] == nil
        new_cart["#{name} W/COUPON"] = {
          price: coupon[:cost],
          clearance: new_cart[name][:clearance],
          count: 1
          }
      else
        new_cart["#{name} W/COUPON"][:count] += 1
      end
    end
  end
  #new_cart.delete_if { |name,data| data[:count] < 1 }
  new_cart
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
  cart1 = consolidate_cart(cart)
  cart2 = apply_coupons(cart1, coupons)
  cart3 = apply_clearance(cart2)
  total = 0
  cart3.each do |name, info_hash|
    total += (info_hash[:price] * info_hash[:count]).to_f
  end
  total > 100 ? total * 0.9 : total
end
