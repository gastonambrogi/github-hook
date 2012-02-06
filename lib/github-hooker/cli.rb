module Github
  module Hooker
    class CLI < Thor
      desc "list user/repo", "List hooks in the given repository"
      def list(repo)
        check_config!
        hooks = Github::Hooker.hooks(repo)
        hooks.each do |hook|
          puts "#{hook['url']}"
          puts "> name:   #{hook['name']}"
          puts "> events: #{hook['events'].join(", ")}"
          puts "> config: #{hook['config']}"
          puts
        end
      end

      desc "campfire user/repo events", "Add a campfire hook in the given repository. Events must be separated by commas."
      method_option :room,       :required => true
      method_option :subdomain,  :required => true
      def campfire(repo, events)
        check_config!
        events = split_events(events)
        puts Github::Hooker.add_hook(repo, :name => "campfire", :events => events, :config => options)
      end

      desc "web user/repo events", "Add a web hook in the given repository. Events must be separated by commas."
      method_option :url, :required => true
      def web(repo, events)
        check_config!
        events = split_events(events)
        puts Github::Hooker.add_hook(repo, :name => "web", :events => events, :config => options)
      end

      desc "delete user/repo hook", "Delete the hook 1111 from the given repository"
      def delete(repo, hook)
        check_config!
        puts Github::Hooker.delete_hook(repo, hook)
      end

      private
      def split_events(events)
        events.split(",").map(&:strip)
      end

      def check_config!
        error("~/.github-hooker.yml is not present. Please set 'user', 'password' and 'campfire_token'.") unless File.exist?(File.expand_path(Github::Hooker.config_filename))
      end

      def error(message)
        puts message
        exit 1
      end
    end
  end
end
