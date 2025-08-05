# Telegram-countdown

A Telegram bot that automatically updates group chat titles with countdown and creates visual progress banners.

## Features

-   **Daily countdown updates**: Automatically updates group chat title with days remaining
-   **Visual progress banner**: Creates a progress image showing completion percentage
-   **Customizable schedule**: Runs daily at midnight UTC+8 (configurable via cron)
-   **Manual trigger**: Can be triggered manually via GitHub Actions workflow dispatch

## How it works

The bot calculates progress between a start date and target date, then:

1. Updates the group chat title with remaining days
2. Creates a visual banner by splitting an image based on progress percentage
3. Updates the group chat photo with the progress banner

## Setup

1. Click "Use this template" at the top right
2. Add a banner image named `banner.jpg` to the repository root
3. Configure the following GitHub secrets:
    - `TELEGRAM_BOT_TOKEN`: Bot token from [@BotFather](https://t.me/BotFather)
    - `TELEGRAM_CHAT_ID`: Chat ID of the target group chat
    - `TELEGRAM_START_DATE`: Start date in format `YYYY-MM-DD` (UTC)
    - `TELEGRAM_TARGET_DATE`: Target date in format `YYYY-MM-DD` (UTC)
4. Add the bot to your group chat and make it an admin
5. Customize the chat title format in `convert-and-upload.sh` if needed

## Configuration

-   **Schedule**: Edit the cron expression in `.github/workflows/countdown.yml` to change when updates occur
-   **Title format**: Modify the `TITLE` variable in `convert-and-upload.sh`
-   **Image processing**: Adjust ImageMagick commands in the script for different visual effects

## License

This project is made by [Elvis Mao](https://github.com/Edit-Mr), licensed under the Do What The Fuck You Want To Public License - see the [LICENSE](LICENSE) file for details.
