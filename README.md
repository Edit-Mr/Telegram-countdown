# Telegram-countdown

Telegram bot uses group chat title to countdown

## How to use

1. Click use this template at the top right.
2. Config title of group chat at `.github/workflows/telegram-countdown.yml`.
3. Config variables in GitHub secrets
    - `TELEGRAM_TARGET_DATE`: Date to countdown to, in format `YYYY-MM-DD` (UTC).
    - `TELEGRAM_BOT_TOKEN`: Bot token from BotFather.
    - `TELEGRAM_CHAT_ID`: Chat ID of the group chat.
4. Add bot to group chat.

## License

This project is made by [Elvis Mao](https://github.com/Edit-Mr), licensed under the Do What The Fuck You Want To Public License - see the [LICENSE](LICENSE) file for details.
