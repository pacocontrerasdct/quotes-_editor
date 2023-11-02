
class LineItemDate < ApplicationRecord
  
  has_many :line_items, dependent: :destroy

  belongs_to :quote

  validates :date, presence: true, uniqueness: { scope: :quote_id }

  scope :i_decide_order, -> { order(date: :asc) }

  def previous_date
    quote.line_item_dates.i_decide_order.where("date < ?", date).last
  end
end
