b1 = Brewery.create name: "Koff", year: 1897, active: true
b2 = Brewery.create name: "Malmgard", year: 2001, active: true
b3 = Brewery.create name: "Weihenstephaner", year: 1040, active: true

s1 = Style.create name: "IPA", description: "Testing"
s2 = Style.create name: "Lager", description: "More testing"

b1.beers.create name: "Iso 3", style: s1
b1.beers.create name: "Karhu", style: s1
b1.beers.create name: "Tuplahumala", style: s1
b2.beers.create name: "Huvila Pale Ale", style: s2
b2.beers.create name: "X Porter", style: s2
b3.beers.create name: "Hefeweizen", style: s2
b3.beers.create name: "Helles", style: s1

u = User.create username: "user", password: "Us3r", password_confirmation: "Us3r"

# u.ratings.create beer: b1.beers.first, score: 10
# u.ratings.create beer: b2.beers.first, score: 20
