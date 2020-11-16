
require 'rss'
require 'open3'
require 'discordrb'
require 'feedjira'
class GmailAlert
        Json = {
                "embed": {
                        "title": "POSITIVE COVID-19 ALERT",
                        "description": "",
                        "color": 12596198,
                        "thumbnail": {
                                "url": "https://media.discordapp.net/attachments/674737776092250133/769660861144760340/1153px-Warning_icon.png"
                        },
                        "author": {
                                "name": "Utica College",
                                "icon_url": "https://images-ext-2.discordapp.net/external/I_phX2NzE807B_HsyMm0gd2imwm0K8NBZqqn9FxrxrQ/https/pbs.twimg.com/profile_images/513702612345298944/GpLSjXZ4.jpeg"
                        }
                }
        }
        Bot = Discordrb::Commands::CommandBot.new token: '', client_id:  , prefix: '.'

        def discord(title, summary)
                Bot.channel(626859163242201092).send_embed do |embed|
                        embed.title = "POSITIVE COVID-19 ALERT"
                        embed.colour = 0xc033e6
                        embed.url = "https://discordapp.com"
                        embed.description = summary
                        embed.thumbnail = Discordrb::Webhooks::EmbedThumbnail.new(url: "https://media.discordapp.net/attachments/674737776092250133/769660861144760340/1153px-Warning_icon.png")
                        embed.author = Discordrb::Webhooks::EmbedAuthor.new(name: "Utica College", icon_url: "https://images-ext-2.discordapp.net/external/I_phX2NzE807B_HsyMm0gd2imwm0K8NBZqqn9FxrxrQ/https/pbs.twimg.com/profile_images/513702612345298944/GpLSjXZ4.jpeg")
                end
        end
        def get_gmail
                # enter curl command
                command = %q{curl 'https://mail.google.com/mail/u/1/feed/atom'}
                stdout, status = Open3.capture2(command)
          return stdout
        end
        def run
          FileUtils.mkdir_p 'configs'
          FileUtils.touch(File.join("configs", "utica.txt"))
          feed = Feedjira.parse(get_gmail)
          feed.entries.each do |line|
            if line.title.to_s.match("POSITIVE COVID-19 ALERT")
              if ( !File.read(File.join("configs", "utica.txt")).include?(line.published.to_s))
                discord(line.title, line.summary)
                File.open(File.join("configs","utica.txt"), "a") { |file| file.write( line.published.to_s + "\n") }
              end

            end
          end
        end
end

GmailAlert.new.run
