# github-hooker

This is an internal gem at PlataformaTec.

## Configuration

First, create ~/.github-hooker.yml with

```yml
user: github_username
password: github_password
campfire_token: campfire_api_token
```

### Why I need to write my password?

The hook API is only accessible by the v3 Github API. There's a Oauth2 authentication method, but in order to use that you would need to set up a new application with Github, and then collect the token by an http callback (that must be accessible on the web). For the sake of simplicity, we use the other way to authenticate (http auth basic).

Then you can use the command `github-hooker` to list, create web and campfire hooks or delete them. Other hooks are not yet implemented (pull requests are appreciated!).

## Usage

The user specified MUST have administration rights for the repositories you want to set/delete hooks.

### List hooks

```
github-hooker list plataformatec/devise 
```

### Create a new web hook

```
github-hooker web plataformatec/devise "pull_requests, push" --url=http://mycallback.com/callback
```

This creates a new web hook that calls the url specified by `--url`. The events that this hooks listens must be the third argument and they must be separeted by commas. 

### Create a new campfire hook

```
github-hooker campfire plataformatec/devise pull_requests,push,issue_comment --room="My Room" --subdomain="My Subdomain"
```

Creates a new campfire hook. The token used for authentication with Campfire must be provided in your `~/.github-hooker.yml` (see Configuration above).

### Delete a hook

```
github-hooker delete plataformatec/devise 1010
```

Deletes the hook 1010 from the given repository. You can get the hook id from the url listed in `github-hooker list user/repo`.

## Events

The available events that github gives us are:

Campfire events:

- push
- pull_requests
- issues

Web events:

- push
- pull_requests
- issues
- issue_comment

Github's documentation about hooks (http://developer.github.com/v3/repos/hooks/ and https://api.github.com/hooks) does not have all these hooks listed, but they are working with us.


## License

upcoming!
