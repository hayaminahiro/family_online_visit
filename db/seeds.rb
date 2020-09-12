# deviseの場合、~.save!しないとpasswordがseedに反映されない。
admin = Facility.create!(
  facility_name: "管理者ユーザー",
  email: "admin@email.com",
  password: "password"
)
admin.save!

home = Facility.create!(
  facility_name: "老人ホーム-A",
  email: "home@email.com",
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

99.times do |n|
  name = "sampleご家族-#{n+1}"
  email = "sample#{n+1}@email.com"
  password = "password"
  User.create!(
    name: name,
    email: email,
    password: password
  )
end

99.times do |n|
  name = "入居者-#{n+1}"
  Resident.create!(
    facility_id: 2,
    name: name,
    charge_worker: "担当者-#{n+1}"
  )
end

31.times do |n|
  name = "タイトル-#{n+1}"
  Information.create!(
    facility_id: 2,
    title: name,
    news: "お知らせ-#{n+1}",
    status: 0
  )
end

Information.create!(
    facility_id: 2,
    title: "当システムの利用方法",
    news: "ご利用前にご入居者様の・・・",
    status: 1
)
