# deviseの場合、~.save!しないとpasswordがseedに反映されない。
admin = Facility.create!(
  facility_name: "管理者ユーザー",
  email: "facility_admin@email.com",
  password: "password",
  admin: true
)
admin.save!

# facility_id = 2
home = Facility.create!(
  id: 2,
  facility_name: "老人ホーム-A",
  email: "home-a@email.com",
  password: "password"
)
home.save!

home = Facility.create!(
  facility_name: "老人ホーム-B",
  email: "home-b@email.com",
  password: "password"
)
home.save!

home = Facility.create!(
  facility_name: "老人ホーム-C",
  email: "home-c@email.com",
  password: "password"
)
home.save!

home = Facility.create!(
  facility_name: "老人ホーム-D",
  email: "home-d@email.com",
  password: "password"
)
home.save!

home = Facility.create!(
  facility_name: "老人ホーム-E",
  email: "home-e@email.com",
  password: "password"
)
home.save!

home = Facility.create!(
  facility_name: "老人ホーム-F",
  email: "home-f@email.com",
  password: "password"
)
home.save!

hospital = Facility.create!(
  facility_name: "病院-B",
  email: "hospital@email.com",
  password: "password"
)
hospital.save!

hoiku = Facility.create!(
  facility_name: "保育園-C",
  email: "hoiku@email.com",
  password: "password"
)
hoiku.save!

# passwordは未設定(動き確認する為のseed)
40.times do |n|
  name = "sample施設-#{n + 1}"
  email = "facility#{n + 1}@email.com"
  password = "password"
  Facility.create!(
    facility_name: name,
    email: email,
    password: password
  )
end

puts "施設を作成しました！"

40.times do |n|
  name = "sampleご家族-#{n + 1}"
  email = "sample#{n + 1}@email.com"
  password = "password"
  User.create!(
    name: name,
    email: email,
    password: password,
    postal_code: "0001100",
    prefecture_name: "大阪府",
    address_city: "大阪市",
    address_street: "南堀江",
    phone: "080222333"
  )
end

puts "ご家族ユーザを作成しました！"

40.times do |n|
  name = "入居者-#{n + 1}"
  Resident.create!(
    facility_id: 2,
    name: name,
    charge_worker: "担当者-#{n + 1}"
  )
end

puts "入居者を作成しました！"

31.times do |n|
  name = "タイトル-#{n + 1}"
  Information.create!(
    facility_id: 2,
    title: name,
    news: "お知らせ-#{n + 1}",
    status: 0
  )
end

Information.create!(
    facility_id: 1,
    title: "当システムの利用方法",
    news: "ご利用前にご入居者様の・・・",
    status: 1
  )

puts "お知らせを作成しました！"
