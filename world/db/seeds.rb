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
    [ "วิมลรัตน์", "คำเอี่ยม", "มะเฟือง", "wimonrat", "wimonrat123", "wimonrat@mailinator.com", true, "คนธรรมดา" ],
    [ "ชยพัทธ์", "แก้ววิไล", "วอลล์", "chayapat", "chayapat123", "chayapat@mailinator.com", false, "คนผิดปกติ" ],
    [ "อนันตญา", "ไชยสงคราม", "ไข่มุก", "anantaya", "anantaya123", "anantaya@mailinator.com", true, "คนพิเศษ" ],
    [ "พริมา", "วัฒนโกศล", "ต้นอ้อ", "prima", "prima123", "prima@mailinator.com", true, "คนไม่ทั่ว" ],
    [ "ชยุตรา", "ศิริธาดา", "จ้า", "chayutara", "chayutara123", "chayutara@mailinator.com", true, "" ],
    [ "ธัชพล", "สันติวงษ์", "มัค", "tatchapol", "tatchapol123", "tatchapol@mailinator.com", true, "ไม่ยอมคน" ],
    [ "ถิรพล", "อนันต์ศัพทเจริญ", "เพิ่ม", "thirapol", "thirapol123", "thirapol@mailinator.com", true, "คนนิดเดียว" ],
    [ "ธนา", "วิชิตรัตนาพร", "มัค", "thana", "thana123", "thana@mailinator.com", true, "คนอะไร" ],
    [ "ธยาดา", "อินทรประสิทธิ์", "แบมบี้", "thayada", "thayada123", "thayada@mailinator.com", true, "คนธรรพ์" ],
    [ "รัญชนา", "วีรภัทรเมธี", "เก๋", "ranchana", "ranchana123", "ranchana@mailinator.com", false, "คนค้นคน" ],
    [ "วรพงษ์", "จิตตะภิเษก", "กุย", "worapong", "worapong123", "worapong@mailinator.com", true, "" ]
]

users.each do |user|
    firstname, lastname, nickname, login, password, email, is_mentor, bio = user
    u = User.new(
        firstname: firstname,
        lastname: lastname,
        nickname: nickname,
        login: login,
        password: password,
        email: email,
        is_mentor: is_mentor,
        bio: bio
    )
    u.save
end
