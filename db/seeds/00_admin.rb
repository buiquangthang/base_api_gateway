puts "Creating Admin"

User.create username: 'admin_01',
            email: 'admin_01@example.com',
            password: '123456',
            password_confirmation: '12345678',
            role: 'admin'

User.create username: 'admin_02',
            email: 'admin_02@example.com',
            password: '123456',
            password_confirmation: '12345678',
            role: 'admin'

