# A simple extension to make colorful logs with emojis
class String
    def log(prefix, color_code)
        "#{prefix}\e[#{color_code}m#{self}\e[0m"
    end
    def error
        log("❌ ", 31)
    end

    def info
        log("", 34)
    end  

    def success
        log("✅ ", 32)
    end
end