class AddMockMembers < ActiveRecord::Migration[7.2]
  def change
    if ENV["RAIL_ENV"] = "development"
      members = [
        ["วิมลรัตน์", "คำเอี่ยม", "มะเฟือง", "wimonrat", "wimonrat123"],
        ["ชยพัทธ์", "แก้ววิไล", "วอลล์", "chayapat", "chayapat123"],
        ["อนันตญา", "ไชยสงคราม", "ไข่มุก", "anantaya", "anantaya123"],
        ["พริมา", "วัฒนโกศล", "ต้นอ้อ", "prima", "prima123"],
        ["ชยุตรา", "ศิริธาดา", "จ้า", "chayutara", "chayutara123"],
        ["ธัชพล", "สันติวงษ์", "มัค", "tatchapol", "tatchapol123"],
        ["ถิรพล", "อนันต์ศัพทเจริญ", "เพิ่ม", "thirapol", "thirapol123"],
        ["ธนา", "วิชิตรัตนาพร", "มัค", "thana", "thana123"],
        ["ธยาดา", "อินทรประสิทธิ์", "แบมบี้", "thayada", "thayada123"],
        ["รัญชนา", "วีรภัทรเมธี", "เก๋", "ranchana", "ranchana123"]
      ]

      Member.delete_all
      ActiveRecord::Base.connection.execute("DELETE FROM sqlite_sequence WHERE name='members';")
    
      members.each do |member|
        firstname, lastname, nickname, login, password = member
        m = Member.new(
          firstname: firstname,
          lastname: lastname,
          nickname: nickname,
          login: login,
          password: password
        )
        m.save
      end
    end
  end
end
