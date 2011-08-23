#!/bin/sh
heroku console "p=Product.where(:_id => $1).first;p.sold=true;p.save"
