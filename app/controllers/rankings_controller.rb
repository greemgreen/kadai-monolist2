class RankingsController < ApplicationController
  def want
    @ranking_counts = Want.ranking
    @items = Item.find(@ranking_counts.keys)
  end
  def hold
    @ranking_counts = Hold.ranking
    @items = Item.find(@ranking_counts.keys)
  end
end