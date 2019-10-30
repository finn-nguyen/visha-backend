users = []
for i in 1..10 do
  users << User.create(username: Faker::Internet.user_name, password: '123456')
end

links = [
  "https://www.youtube.com/watch?v=VfJbknR_svI",
  "https://www.youtube.com/watch?v=lrb2FwmwOmU",
  "https://www.youtube.com/watch?v=5FbyD_UPhFQ",
  "https://www.youtube.com/watch?v=2RSLHjGp7as",
  "https://www.youtube.com/watch?v=Fi_RxjAKurw",
  "https://www.youtube.com/watch?v=z9vqQKRjTC8",
  "https://www.youtube.com/watch?v=H4h-y7quIDQ",
  "https://www.youtube.com/watch?v=lrb2FwmwOmU&t=4s",
  "https://www.youtube.com/watch?v=DSvOsXKT7Sc",
  "https://www.youtube.com/watch?v=0XMGGtYyYCM",
  "https://www.youtube.com/watch?v=aUpxJEOhG2o"
]

for i in 1..50 do
  index = i % links.count
  user_index = i % users.count
  Video.create(link: links[index], user_id: users[user_index].id)
end