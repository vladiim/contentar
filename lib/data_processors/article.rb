# IF YOU STILL DON'T NEED THIS DELETE IT!

# class ArticleDataProcessor
#   attr_reader :json_data, :parsed_data

#   def data(json_data)
#     @json_data   = json_data
#     @parsed_data = parse_data
#     process
#   end

#   private

#   def process
#     article = parsed_data.fetch('content') { '' }
#     { article: article }
#   end

#   def parse_data
#     JSON.parse(json_data).fetch('data') { {} }
#   end
# end