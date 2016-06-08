# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Example:
#
#   Person.create(first_name: 'Eric', last_name: 'Kelly')
User.destroy_all
Meetup.destroy_all
Member.destroy_all
user = User.create(provider: "12345", uid: "1", username: "test_user", email: "test@test.com", avatar_url: "http://www.icons101.com/icons/6/Pusheen_by_StephaniJosebuch/128/pusheen_5.png")
user2 = User.create(provider: "12345", uid: "2", username: "Pusheen_the_cat", email: "test@test.com", avatar_url: "http://www.icons101.com/icons/6/Pusheen_by_StephaniJosebuch/128/pusheen_7.png")
user3 = User.create(provider: "12345", uid: "3", username: "JohnDoe87", email: "test@test.com", avatar_url: "http://www.icons101.com/icons/6/Pusheen_by_StephaniJosebuch/128/pusheen_3.png")
user4 = User.create(provider: "12345", uid: "4", username: "MarySue9", email: "test@test.com", avatar_url: "http://www.icons101.com/icons/6/Pusheen_by_StephaniJosebuch/128/pusheen_2.png")
user5 = User.create(provider: "12345", uid: "5", username: "Herpdep", email: "test@test.com", avatar_url: "http://www.icons101.com/icons/6/Pusheen_by_StephaniJosebuch/128/pusheen_1.png")
meetup = Meetup.create(name: "test meetup", description: "test", location: "Boston")
meetup1 = Meetup.create(name: "Stow Meetup", description: "A meetup super far away", location: "Stow")
meetup2 = Meetup.create(name: "Science Fans", description: "Come visit the BMoS", location: "Cambridge")
Member.create(user_id: user.id, meetup_id: meetup.id, creator: true)
Member.create(user_id: user2.id, meetup_id: meetup1.id, creator: true)
Member.create(user_id: user3.id, meetup_id: meetup2.id, creator: true)
Member.create(user_id: user4.id, meetup_id: meetup2.id, creator: false)
Member.create(user_id: user5.id, meetup_id: meetup1.id, creator: false)
