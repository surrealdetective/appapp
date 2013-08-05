class Search
  attr_accessor :results
  MODELS = [:dossier, :hashtag, :student]

  # options
  # things like autocomplete
  # if you can imagine how to implement that
  def initialize(query, options = {})
    @query = query
    process
  end

  private

  def process
    @results = MODELS.collect do |type|
      type.to_s.constantize.search(@query)
    end#.flatten maybe
    # maybe return a hash?
    # {:dossier => [], :hashtag => [], :student => []}
  end

end

# @results = Search.new("av")
# @results #=> [#<Student name: Avi>, #<Student last_name: David>, #<Hashtag :avid>]