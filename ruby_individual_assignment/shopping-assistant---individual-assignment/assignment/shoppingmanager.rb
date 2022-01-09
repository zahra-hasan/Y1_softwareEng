
# This is an example of how much items cost in different shops
shopPricesExample={'tesco'=>{'milk'=>135,'corn flakes'=>205,'tomatoes'=>125,'potatoes'=>130,'pasta'=>80,'bread'=>60},
'lidl'=>{'milk'=>115,'bread'=>45,'pasta'=>60,'a4 paper'=>340},
'aldi'=>{'milk'=>125,'christmas lights'=>990, 'bread'=>38,'baked beans'=>35,'potatoes'=>120,'pasta'=>70}}

# Some shops are generally cheaper or located closer. Hence they describe
# a preference to visit some over others. Shops located earlier in this
# list are preferred over those later in the list.
shopPreferencesExample=['aldi','lidl','tesco']

productToBuyExample=['milk','bread','corn flakes','pasta','baked beans','tomatoes','potatoes','bananas']

# You need to implement this function.
def priceOfShoppingSelection(selection,shops)
  price=0
  totalPrice=0
  selection.each do |product,shop|
    if shops.has_key?(shop)
      if shops[shop].has_key?(product)
        price = shops[shop][product]
      end
      totalPrice += price
    end
  end
  return totalPrice
end

# Given a list of products (with no repetitions) and a price list, counts the 
# number of items that can be bought from that shop. PriceList is a hash such as
# {'milk'=>115,'bread'=>45,'pasta'=>60,'a4 paper'=>340}
def countItemsInShop(products,priceList)
	count=0
	products.each do |product|
		if priceList.has_key?(product)
			count+=1
		end
	end
	return count
end


# You need to implement this function.
def removeDuplicates(products)
		hash = Hash[products.collect{|value| [value]}]
	  return hash.keys
end
# You need to implement this function.
def findProductsInShops(products,shops,preferences)
	array = Array.new
	products.each do |product|
		preferences.each do |shop|
		 if shops.empty? == false
		   if shops[shop].has_key?(product)
            array << product
        end
      end
    end
	end
	return Hash[array.collect{|item|[item]}].keys
end

# You need to implement this function.
def findBestShop(products,shops,preferences)
  products = removeDuplicates(products)
  hash = Hash.new
	preferences.each do |shop|
		if shops.has_key?(shop)
		   hash[shop] = [countItemsInShop(products,shops[shop])]
     end 
  end 
	bestShop = hash.key(hash.values.max)
	return bestShop 
end

# You need to implement this function.
def selectItems(products,selection,shops,preferences)
	hash = Hash.new
	array = Array.new
	bestShop = findBestShop(products,shops,preferences)
	shops[bestShop].each do |item,value|
		i=0
		while i<products.length
			if products[i] == item
				products.delete(item)
				array << item
				hash[item]=bestShop
        end 
			i+=1
		end	
	end
	  selection.merge!(hash)
  return products
end

# You need to implement this function.
def selectItemsRecurse(productsToBuy,selection,shops,preferences)
   products = (removeDuplicates(findProductsInShops(productsToBuy,shops,preferences)))
   leftProducts =  selectItems(products,selection,shops,preferences)
  while leftProducts.empty? != true 
    leftProducts = selectItems((removeDuplicates(findProductsInShops(leftProducts,shops,preferences))),selection,shops,preferences)
	end
end

# The condition below makes it possible to run your program interactively but 
# it can still be tested by unit tests which only call individual functions.
# In this example, the program is supposed to print 
#Products to buy: {"milk"=>"tesco", "bread"=>"tesco", "corn flakes"=>"tesco", "pasta"=>"tesco", "tomatoes"=>"tesco", "potatoes"=>"tesco", "baked beans"=>"aldi"}
#Price: 770
if __FILE__ == $PROGRAM_NAME
	selection={}
	selectItemsRecurse(productToBuyExample,selection,shopPricesExample,shopPreferencesExample)
	puts("Products to buy: #{selection}")
	puts("Price: #{priceOfShoppingSelection(selection,shopPricesExample)}")
end

