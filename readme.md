bolt-project-pi
==============

Getting Bolt Apply to work
-----------

This is an example bolt project directory for working with Raspberry Pi's.

This requires to get Bolt apply working (and on any other system without a native puppet-agent package):

Mark your raspberry pi's as having the puppet-agent feature in the inventory file, this skips the puppet agent installation and version check part of apply_prep:

```
features:
  - 'puppet-agent'
```

or

```
features: ['puppet-agent']
```

Are both valid.

And under the transport configuration settings, you need to specify which ruby to use, as Bolt apply will default to /opt/puppetlabs/puppet/bin/ruby (which is what puppet-agent would use). I do this in the inventory group as well, since I only want to use this for the systems I know I don't have puppet on.

```
ssh:
  interpreters:
    rb: /usr/bin/ruby
```

See the included inventory.yaml for a inventory group with that feature enabled.


Lastly, you will need Puppet installed in the ruby at that path somehow, see the `pi::gem_puppet` task for a simple (and not exactly best way) to get Puppet on the system.

Bootstrap vs ongoing
-----------
By default, the raspbian os can be configured to start with SSH, and a user with the name of pi, password of raspberry to connect with. My initial configuration of the Pi includes installing my own user account, installing my ssh key, etc, so I'd like to use pi:raspberry to only connect to a node once, and then use my keys and other credentials for future plans.

The included `pi::bootstrap` plan shows how to do a one off plan run with the provided nodes with the settings from the inventory group named raspberrybootstrap, before invoking the `pi::testing` plan (which could be a full configuration module / setup / deployment, etc).