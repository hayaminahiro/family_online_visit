Information.create!(title: "当システムの利用方法",
                      news: "ご利用前にご入居者様の・・・",
                    status: 1)

Facility.create!(facility_name: "老人ホーム-A",
             email: "home@email.com",
             password: "password"
)

Facility.create!(facility_name: "病院-B",
                 email: "hospital@email.com",
                 password: "password"
)

Facility.create!(facility_name: "保育園-C",
                 email: "hoiku@email.com",
                 password: "password"
)

99.times do |n|
  name = "sampleご家族-#{n+1}"
  email = "sample#{n+1}@email.com"
  password = "password"
  User.create!(name: name,
               email: email,
               password: password)
end

99.times do |n|
  name = "入居者-#{n+1}"
  Resident.create!(name: name)
end
