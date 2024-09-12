class Mentor
    def self.all
        User.includes(:skills)
            .where(is_mentor: true)
    end
end
