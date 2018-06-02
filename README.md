# Social Health Online
Social Health is dedicated to improving the wellness of people and 
their communities by promoting healthier social lives with rewards 
and incentives.

## Development
Prerequisite: Install `git`, `yarn` package manager using `npm`, `ruby 2.5.1` and rails `5.2.0.rc1` using `rvm`

To contribute, fork and clone.

    git clone git@github.com:socialhealthonline/social_health_online.git

The code is in rails. Use a rails IDE of your choice, like Rubymine.

To set up the development environment, run:

    ```
    ./bin/setup
    ./bin/rails s
    ```
## Testing

```
./bin/rake
```

## Heroku Deployment

### Staging

```
git remote add staging https://git.heroku.com/staging-social-health-online.git
```

https://staging-social-health-online.herokuapp.com/

### Production

```
git remote add heroku https://git.heroku.com/social-health-online.git
```

https://www.socialhealthonline.com/