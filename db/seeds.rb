require 'random_data'

#Create Posts

puts "#{Post.count}"

#code with error I wrote / created two posts with the same title of "Cire"
#Post.find_or_create_by(title: "Cire") do
#   Post.create!(
#      title: "Cire",
#     body: "What's the first rule? You don't talk about X, what's the second rule? YOU DO NOT TALK ABOUT X."
#    )
#end

#Alt code
Post.find_or_create_by(title: "A unique title", body: "Body text")


50.times do

    Post.create!(
  
        title: RandomData.random_sentence,
        body: RandomData.random_paragraph
    )
end
posts = Post.all

# Create Comments
100.times do
    Comment.create!(
        
        post: posts.sample,
        body: RandomData.random_paragraph
    )
end


puts "#{Post.count}"

puts "Seed finished"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"