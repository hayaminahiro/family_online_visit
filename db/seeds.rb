# deviseの場合、~.save!しないとpasswordがseedに反映されない。
admin = Facility.create!(
  id: 1,
  facility_name: "管理者ユーザー",
  email: "facility_admin@email.com",
  password: "password",
  password_confirmation: "password",
  admin: true
)
admin.save!

# facility_id = 2
home = Facility.create!(
  id: 2,
  facility_name: "老人ホーム-A",
  email: "home-a@email.com",
  password: "password",
  password_confirmation: "password"
)
home.save!

home = Facility.create!(
  id: 3,
  facility_name: "老人ホーム-B",
  email: "home-b@email.com",
  password: "password",
  password_confirmation: "password"
)
home.save!

home = Facility.create!(
  id: 4,
  facility_name: "老人ホーム-C",
  email: "home-c@email.com",
  password: "password",
  password_confirmation: "password"
)
home.save!

home = Facility.create!(
  id: 5,
  facility_name: "老人ホーム-D",
  email: "home-d@email.com",
  password: "password",
  password_confirmation: "password"
)
home.save!

home = Facility.create!(
  id: 6,
  facility_name: "老人ホーム-E",
  email: "home-e@email.com",
  password: "password",
  password_confirmation: "password"
)
home.save!

home = Facility.create!(
  id: 7,
  facility_name: "老人ホーム-F",
  email: "home-f@email.com",
  password: "password",
  password_confirmation: "password"
)
home.save!

hospital = Facility.create!(
  id: 8,
  facility_name: "病院-B",
  email: "hospital@email.com",
  password: "password",
  password_confirmation: "password"
)
hospital.save!

hoiku = Facility.create!(
  id: 9,
  facility_name: "保育園-C",
  email: "hoiku@email.com",
  password: "password",
  password_confirmation: "password"
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
    password: password,
    password_confirmation: "password"
  )
end

puts "施設を作成しました！"

40.times do |n|
  name = "sampleご家族-#{n + 1}"
  email = "sample#{n + 1}@email.com"
  password = "password"
  User.create!(
    id: n + 1,
    name: name,
    email: email,
    password: password,
    postal_code: "1234567",
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
    id: n + 1,
    facility_id: 2,
    name: name,
    charge_worker: "担当者-#{n + 1}"
  )
end

40.times do |n|
  name = "入居者-#{n + 41}"
  Resident.create!(
    id: n + 41,
    facility_id: 3,
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

FacilityUser.create!(
  user_id: 1,
  facility_id: 2
)

FacilityUser.create!(
  user_id: 1,
  facility_id: 3
)

FacilityUser.create!(
  user_id: 2,
  facility_id: 2
)

FacilityUser.create!(
  user_id: 3,
  facility_id: 2
)

FacilityUser.create!(
  user_id: 4,
  facility_id: 2
)

puts "施設を登録しました"

# 同じユーザ(user_1)から複数施設(home_a, home_b)への申請/承認 =================================================================================
# user_1からA施設への申請/承認
user1_to_home_a = RequestResident.create!(
  user_id: 1,
  facility_id: 2,
  req_name: "入居者-1",
  req_approval: 0
)

Relative.create!(
  user_id: 1,
  resident_id: 1
)

user1_to_home_a.update(
  user_id: 1,
  facility_id: 2,
  req_approval: 1
)

# user_1からB施設への申請/承認
user1_to_home_b = RequestResident.create!(
  user_id: 1,
  facility_id: 3,
  req_name: "入居者-41",
  req_approval: 0
)

Relative.create!(
  user_id: 1,
  resident_id: 41
)

user1_to_home_b.update(
  user_id: 1,
  facility_id: 3,
  req_approval: 1
)

# user_2からA施設への申請/承認 ==============================================================================================================
user2_to_home_a = RequestResident.create!(
  user_id: 2,
  facility_id: 2,
  req_name: "入居者-8",
  req_approval: 0
)

Relative.create!(
  user_id: 2,
  resident_id: 8
)

user2_to_home_a.update(
  user_id: 2,
  facility_id: 2,
  req_approval: 1
)

# 異なるユーザ(user_3, user_4)から同じ施設(home_a)への申請のみ ===============================================================================
# user_3からA施設への申請
user3_to_home_a = RequestResident.create!(
  user_id: 3,
  facility_id: 2,
  req_name: "user_3からの申請テスト",
  req_approval: 0
)

# user_4からA施設への申請
user4_to_home_a = RequestResident.create!(
  user_id: 4,
  facility_id: 2,
  req_name: "user_4からの申請テスト",
  req_approval: 0
)

puts "入居者申請/承認をしました！"
