PayPal Payments for Dashing
===========================

This widget for Dashing allows to see your recent transactions using PayPal's new REST-API.

Usage
------
To use the widgets the following steps must be followed:

Gemfile
_____
To use this widget the following Gem has to be added to the Gemfile:
    
```require 'paypal-sdk-rest'```

API
____
The API must be configured in the `config.ru` file:

```
PayPal::SDK::REST.set_config(
	:ssl_options 	=> {}, # Set ssl options
	:mode 			=> :sandbox,  # Set :sandbox or :live
	:client_id     	=> "YOUR ID",
	:client_secret 	=> "YOUR SECRET"
)
```
To switch from sandbox to live development you need to change the API credentials and the mode to live.

Interval
____
The schedule is using a default of 2 minutes. To change this you can just modify the `paypal.rb` file:

```
	SCHEDULER.every '30s' do
```
… or minutes:

```
	SCHEDULER.every '5m' do
```

Layout
____
Finally you need to add the widget to your layout (see `dashboard/yourlayout.erb`):

```
<li data-row="1" data-col="1" data-sizex="2" data-sizey="1">
	<div data-id="payments" data-view="Paypal" 		data-title="PayPal Payments" data-moreinfo="Your recent transactions"></div>
</li>
```
Right now only the 2x1 layout is supported.

Author
----
Tim Messerschmidt
- PayPal Developer Evangelist
- tmesserschmidt@paypal.com