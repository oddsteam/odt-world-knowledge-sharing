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
Skill.delete_all
ActiveRecord::Base.connection.execute("DELETE FROM sqlite_sequence WHERE name='skills';")

users = [
    [ "วิมลรัตน์", "คำเอี่ยม", "มะเฟือง", "wimonrat", "wimonrat123", "wimonrat@mailinator.com", true, "คนธรรมดา", [ "SQL", "Data Analytics", "Domain Driven Design" ] ],
    [ "ชยพัทธ์", "แก้ววิไล", "วอลล์", "chayapat", "chayapat123", "chayapat@mailinator.com", false, "คนผิดปกติ", [] ],
    [ "อนันตญา", "ไชยสงคราม", "ไข่มุก", "anantaya", "anantaya123", "anantaya@mailinator.com", true, "คนพิเศษ", [ "SQL", "DBA" ] ],
    [ "พริมา", "วัฒนโกศล", "ต้นอ้อ", "prima", "prima123", "prima@mailinator.com", true, "คนไม่ทั่ว", [ "AI", "Data Analytics" ] ],
    [ "ชยุตรา", "ศิริธาดา", "จ้า", "chayutara", "chayutara123", "chayutara@mailinator.com", true, "", [ "Scrum", "Agile", "Kanban" ] ],
    [ "ธัชพล", "สันติวงษ์", "มัค", "tatchapol", "tatchapol123", "tatchapol@mailinator.com", true, "ไม่ยอมคน", [ "Project Management" ] ],
    [ "ถิรพล", "อนันต์ศัพทเจริญ", "เพิ่ม", "thirapol", "thirapol123", "thirapol@mailinator.com", true, "คนนิดเดียว", [ "QA", "Test Automation" ] ],
    [ "ธนา", "วิชิตรัตนาพร", "มัค", "thana", "thana123", "thana@mailinator.com", true, "คนอะไร", [ "DevOps", "Security", "Network" ] ],
    [ "ธยาดา", "อินทรประสิทธิ์", "แบมบี้", "thayada", "thayada123", "thayada@mailinator.com", true, "คนธรรพ์", [ "UX", "UI", "Product Discovery" ] ],
    [ "รัญชนา", "วีรภัทรเมธี", "เก๋", "ranchana", "ranchana123", "ranchana@mailinator.com", false, "คนค้นคน", [ "UX", "User Research", "Psychology" ] ],
    [ "วรพงษ์", "จิตตะภิเษก", "กุย", "worapong", "worapong123", "worapong@mailinator.com", true, "", [ "Security", "Network", "Hacking" ] ]
]

all_skills = (users.map do |firstname, lastname, nickname, login, password, email, is_mentor, bio, skills|
    skills
end).flatten.uniq

all_skills.each do |skill|
    s = Skill.new(
        title: skill
    )
    s.save
end

users.each do |user|
    firstname, lastname, nickname, login, password, email, is_mentor, bio, skills = user

    skill_records = Skill.where(title: skills)

    u = User.new(
        firstname: firstname,
        lastname: lastname,
        nickname: nickname,
        login: login,
        password: password,
        email: email,
        is_mentor: is_mentor,
        bio: bio,
        skills: skill_records
    )
    u.save
end
