p "*************************"
p "Welcome to Le Wagon Market Place!"
p "*************************"

# variable setup
market_items = {
  'carrots' => {price: 80, quantity: 7},
  'apples' => {price: 1000, quantity: 5},
  'bananas' => {price: 200, quantity: 8},
  'kiwis' => {price: 500, quantity: 4},
  'grapes' => {price: 2000, quantity: 2},
  'beef' => {price: 400, quantity: 3},
  'chicken' => {price: 150, quantity: 5},
  'pork' => {price: 250, quantity: 4},
  'tofu' => {price: 100, quantity: 8},
  'rice' => {price: 90, quantity: 9}
}
shopping_cart = {} # item, qty
total = 0

# displaying market items
p "Here is what we offer:"
market_items.each do |name, value|
  p "#{name}: ¥#{value[:price]} x qty #{value[:quantity]}"
end
puts ''

# user input
p "What would you like to buy?"
p "Type 'exit' to leave to shopping cart"
item = gets.chomp.downcase
qty = 0

while item != 'exit'
  # check if item exists or not
  if market_items.key?(item)
    p 'How many would you like to buy?'
    qty = gets.chomp.to_i
    # check if in stock
    if market_items[item][:quantity] >= qty
      # check if in cart
      if shopping_cart.key?(item)
        shopping_cart[item] += qty
      else
        shopping_cart[item] = qty
      end
      market_items[item][:quantity] -= qty
      p "You have qty #{shopping_cart[item]} of #{item} in your cart!"
      total += market_items[item][:price] * qty
      puts ''
    # check if remaining is desired
    elsif market_items[item][:quantity] > 0
      p "We only have #{market_items[item][:quantity]} left."
      p "Would you like the remaining stock? (Y/N)"
      answer = gets.chomp.upcase
      # addition to shopping cart check
      if answer == 'Y'
        qty = market_items[item][:quantity]
        if shopping_cart.key?(item)
          shopping_cart[item] += qty
        else
          shopping_cart[item] = qty
        end
        market_items[item][:quantity] -= qty
        p "You have qty #{shopping_cart[item]} of #{item} in your cart!"
        total += market_items[item][:price] * qty
        puts ''
      else
        p "Sorry we could not fulfill your request."
        puts ''
      end
    else
      p "Sorry, we are out of stock for #{item}"
    end
  else
    p "Sorry, we don't have that item."
  end
  # reset
  p "What would you like to buy?"
  p "Type 'exit' to leave to shopping cart" 
  item = gets.chomp.downcase
  qty = 0
end

# print reciept
puts ''
p "See below for your reciept"
p "*************************"
p "Le Wagon Shopping Reciept"
puts ''
shopping_cart.each do |item, quantity|
  price = market_items[item][:price] * quantity
  p "#{item} x #{quantity} : ¥#{price}"
end
puts ''
p "Total = ¥#{total}"
puts ''
p "Thank you for shopping with us."
p "*************************"
