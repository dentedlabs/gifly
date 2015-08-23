user = User.create({
  name: Faker::Hack.name
})

40.times do
  Video.create({
    user: user,
    tags: [Faker::Hacker.noun, Faker::Hacker.verb, Faker::Hacker.ingverb],
    source: Faker::Avatar.image
  })
end
