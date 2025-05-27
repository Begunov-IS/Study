require 'date'

class Product
    attr_accessor :amount, :category, :date

    def initialize(amount, category, date = Date.today)
        @amount = amount
        @category = category
        @date = Date.parse(date.to_s)
    end
end

class ExpenseTracker

  def initialize(products)
    @products = products
  end

   def sum_by_date(from_date, to_date = from_date)
    begin
        from_date = Date.parse(from_date.to_s)
    rescue ArgumentError
        return "Wrong date!" 
        end
    begin
        to_date = Date.parse(to_date.to_s)
    rescue ArgumentError
        return "Wrong date!" 
        end
    @products.select { |product| product.date >= from_date && product.date <= to_date }.sum { |product| product.amount }
  end

  def sum_by_category(category)
    @products.select { |product| product.category == category }.sum { |product| product.amount }
  end

  def top_expenses(limit = 3)
    @products.sort_by { |product| -product.amount }.first(limit)
  end

  def cheapest_expenses(limit = 3)
    @products.sort_by { |product| product.amount }.first(limit)
  end

  def most_frequent_category()
    freq = @products.each_with_object({}) do |product, result|
      result[product.category] ||= 0
      result[product.category] += 1
    end
    max_count = freq.values.max
    return [] if max_count <= 1
    freq.select { |no_need, count| count == max_count }.keys
  end
end

products = [
  Product.new(500, "food", "2024-06-01"),
  Product.new(1200, "rent", "2024-06-01"),
  Product.new(100, "transport", "2024-06-02"),
  Product.new(150, "food", "2024-06-02"),
  Product.new(200, "food", "2024-06-03"),
  Product.new(50, "transport", "2024-06-03")
]

current_tracker = ExpenseTracker.new(products)

puts "Общая сумма за 2024-06-01: #{current_tracker.sum_by_date("2024-06-01")}"
puts "Общая сумма за неделю 2024-06-01: #{current_tracker.sum_by_date("2024-06-01", "2024-06-07")}"
puts "Общая сумма по категории 'food': #{current_tracker.sum_by_category("food")}"
puts "Топ 3 самых дорогих товаров: #{current_tracker.top_expenses()}"
puts "Топ 3 самых дешёвых товаров: #{current_tracker.cheapest_expenses()}"
puts "Самая частая категория: #{current_tracker.most_frequent_category()}"
