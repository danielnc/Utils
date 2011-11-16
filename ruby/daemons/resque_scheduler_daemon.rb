require 'daemon_spawn'
require 'resque_scheduler'
class ResqueSchedulerDaemon < DaemonSpawn::Base
  @@opts = {
      :log_file => File.join(Rails.root, "log", "resque_scheduler.log"),
      :pid_file => File.join(Rails.root, 'tmp', 'pids', 'resque_scheduler.pid'),
      :sync_log => true,
      :working_dir => Rails.root,
      :singleton => true
  }

  def start(args)
    Resque::Scheduler.verbose = true
    Resque::Scheduler.run
  end

  def stop
    Resque::Scheduler.shutdown
  end

  def self.start_daemon
    spawn!(@@opts, ["start"])
  end
  def self.daemon_status
    spawn!(@@opts, ["status"])
  end

  def self.stop_daemon
    spawn!(@@opts, ["stop"])
  end

  def self.restart_daemon
    spawn!(@@opts, ["restart"])
  end
end

