class Quote < ApplicationRecord
	
	has_many :line_item_dates, dependent: :destroy
	
	belongs_to :company

	validates :name, presence: true

	scope :my_order, -> { order(id: :desc) }

	# after_create_commit -> { broadcast_prepend_to "quotes" 
													 # partial: "quotes/quote", // 'partial' default value is equal to 
													 														#   calling to_partial_path -> "quotes/quote", 
													 														#   so we can remove this

													 # locals: { quote: self }, // 'locals' default value is equal to 
													 														#   { model_name.element.to_sym => self } -> equal { quote: self }, 
													 														#   so we can remove this

													 # target: "quotes"  				// 'target' default option is equal to 
													 														#  model_name.plural -> "quotes", so we can remove this
													# }
	# after_update_commit  -> { broadcast_replace_to "quotes" }
	# after_destroy_commit -> { broadcast_remove_to  "quotes" }



	# It is possible to improve the performance of this code 
	# by making the broadcasting part asynchronous using background jobs. 
	# To do this, we only have to update the content of our callbacks 
	# to use their asynchronous equivalents

	# after_create_commit -> { broadcast_prepend_later_to "quotes"
	# after_update_commit  -> { broadcast_replace_later_to "quotes" }
	# after_destroy_commit -> { broadcast_remove_to  "quotes" }

	# Those above three callbacks are equivalent to the following single line
  broadcasts_to ->(quote) { [quote.company, "quotes"] }, inserts_by: :prepend

end
