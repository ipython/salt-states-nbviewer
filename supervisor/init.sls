supervisor_install:
    pkg.installed:
        - name: supervisor
        #    pip.installed:
        #        - name: supervisor
        #        - upgrade: True

#directory node['supervisor']['dir'] do
#  owner "root"
#  group "root"
#  mode "755"
#end
#
#template node['supervisor']['conffile'] do
#  source "supervisord.conf.erb"
#  owner "root"
#  group "root"
#  mode "644"
#  variables({
#    :inet_port => node['supervisor']['inet_port'],
#    :inet_username => node['supervisor']['inet_username'],
#    :inet_password => node['supervisor']['inet_password'],
#    :supervisord_minfds => node['supervisor']['minfds'],
#    :supervisord_minprocs => node['supervisor']['minprocs'],
#    :supervisor_version => node['supervisor']['version'],
#  })
#end
#
#directory node['supervisor']['log_dir'] do
#  owner "root"
#  group "root"
#  mode "755"
#  recursive true
#end


#when "debian", "ubuntu"
#  template "/etc/init.d/supervisor" do
#    source "supervisor.init.erb"
#    owner "root"
#    group "root"
#    mode "755"
#  end
#
#  template "/etc/default/supervisor" do
#    source "supervisor.default.erb"
#    owner "root"
#    group "root"
#    mode "644"
#  end
#
#  service "supervisor" do
#    action [:enable, :start]
#  end

supervisor:
    service:
        - running
        - watch:
            - file: /etc/supervisor/conf.d/nbviewer.conf

/etc/supervisor/conf.d/nbviewer.conf:
    file.managed:
        - source: salt://supervisor/nbviewer.conf.jinja
        - template: jinja
        - mode: 644

updates:
    cmd.run:
        - name: supervisorctl reread
        - watch:
            - file: /etc/supervisor/conf.d/nbviewer.conf
    cmd.run:
        - name: supervisorctl update
        - watch:
            - file: /etc/supervisor/conf.d/nbviewer.conf

