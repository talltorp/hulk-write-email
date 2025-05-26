class AiJobBase < ApplicationJob

  private

    def ask_ai_with(prompt)
      client = OpenAI::Client.new
      response = client.chat( parameters: {
          model: ENV.fetch("SECRET_SUPER_MODEL"), 
          messages: [{ 
            role: "user",
            content: prompt,
            }],
          temperature: 0.7,
      })

      response.dig("choices", 0, "message", "content")
    end
end
