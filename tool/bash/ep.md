[//]: #(home)
[home]: ../../../README.md

[//]: #(doc)
[doc platform whatis]: ../whatis/doc.ptf.md
[metadoc howto]:       ../howto/metadoc.md
[system whatis]:       /about/whatis/system.md
[Jelly github whatis]:       https://github.com/jellyfin/jellyfin

[↖][home]

Related topics

| Topic                                            | Location | Kind    |
| ------------------------------------------------ | -------- | ------- |
| [What is Jelly][Jelly github whatis]|external|github

**Document's status**
- Early stage.
- The project is currently being defined (concepts, architecture, ...)

<h1 align="center">Jelly</h1>


# Working with M3U

# Reference

# Test the Server

```text
http://vod4k.cc/player_api.php?username=YOUR_USERNAME&password=YOUR_PASSWORD
```

If it works, you should see JSON containing things like:

```text
user_info
server_info
```

Then try:

```text
http://vod4k.cc/player_api.php?username=YOUR_USERNAME&password=YOUR_PASSWORD&action=get_vod_categories
```

If that returns a list of categories, **we're in business**.

# Reference 
- https://github.com/worldofiptvcom/xtream-codes-api/blob/master/docs/player-api/overview.md?utm_source=chatgpt.com "xtream-codes-api/docs/player-api/overview.md at master · worldofiptvcom/xtream-codes-api · GitHub"
- https://xtreamiptv.codes/xtream-codes/api/?utm_source=chatgpt.com "Xtream Codes API: The Complete Reference | XtreamIP TV Codes"
- https://github.com/jellyfin/jellyfin
