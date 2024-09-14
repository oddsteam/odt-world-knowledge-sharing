class Mentor
    def self.all
        User.where(is_mentor: true)
    end

    def self.find(id)
        User.find_by(id: id, is_mentor: true)
    end
end
