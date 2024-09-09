# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

User.delete_all
ActiveRecord::Base.connection.execute("DELETE FROM sqlite_sequence WHERE name='users';")

users = [
    ["วิมลรัตน์", "คำเอี่ยม", "มะเฟือง", "wimonrat", "wimonrat123", "wimonrat@mailinator.com"],
    ["ชยพัทธ์", "แก้ววิไล", "วอลล์", "chayapat", "chayapat123", "chayapat@mailinator.com"],
    ["อนันตญา", "ไชยสงคราม", "ไข่มุก", "anantaya", "anantaya123", "anantaya@mailinator.com"],
    ["พริมา", "วัฒนโกศล", "ต้นอ้อ", "prima", "prima123", "prima@mailinator.com"],
    ["ชยุตรา", "ศิริธาดา", "จ้า", "chayutara", "chayutara123", "chayutara@mailinator.com"],
    ["ธัชพล", "สันติวงษ์", "มัค", "tatchapol", "tatchapol123", "tatchapol@mailinator.com"],
    ["ถิรพล", "อนันต์ศัพทเจริญ", "เพิ่ม", "thirapol", "thirapol123", "thirapol@mailinator.com"],
    ["ธนา", "วิชิตรัตนาพร", "มัค", "thana", "thana123", "thana@mailinator.com"],
    ["ธยาดา", "อินทรประสิทธิ์", "แบมบี้", "thayada", "thayada123", "thayada@mailinator.com"],
    ["รัญชนา", "วีรภัทรเมธี", "เก๋", "ranchana", "ranchana123", "ranchana@mailinator.com"]
]

users.each do |user|
    firstname, lastname, nickname, login, password, email = user
    u = User.new(
        firstname: firstname,
        lastname: lastname,
        nickname: nickname,
        login: login,
        password: password,
        email: email
    )
    u.save
end
