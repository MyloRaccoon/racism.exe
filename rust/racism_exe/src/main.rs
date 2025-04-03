use racism_exe::{coin::Coin, enemy::Enemy, miscellaneous::FineIllDoItMyselfResult, player::Player};
use std::io;

fn build_board(width: u32, height: u32, player: Player, enemy: Enemy, coin: Coin) -> String {
    let mut res = String::new();

    for y in 0 .. height {
        for x in 0 .. width {

            if x == 0 || y == 0 || x == width-1 || y == height-1 {
                res += "0"
            } else if x == player.x && y == player.y {
                res += &player.char;
            } else if x == enemy.x && y == enemy.y {
                res += &enemy.char;
            } else if x == coin.x && y == coin.y {
                res += &coin.char;
            } else {
                res += " "
            }

        }
        res += "\n";
    }

    res
}

fn main() -> io::Result<()> {
    const WIDTH: u32 = 10;
    const HEIGHT: u32 = 10;
    let mut player = Player::default();
    let mut enemy = Enemy::new(WIDTH, HEIGHT);
    let mut score = 0;
    let mut coin = Coin::default();
    coin.tp(WIDTH, HEIGHT);
    let mut playing = true;

    while playing {

        println!("{}", build_board(WIDTH, HEIGHT, player.clone(), enemy.clone(), coin.clone()));
        println!("your score: {}$", score);
        println!("Please enter a command : ");

        let mut buffer = String::new();
        let stdin = io::stdin();
        stdin.read_line(&mut buffer)?;

        if buffer == *"e\n".to_string() {

            println!("final score: {score}$");
            playing = false;

        } else if player.motion(buffer.clone(), WIDTH, HEIGHT) == FineIllDoItMyselfResult::Err {
            println!("\"{buffer}\" is not a command. (z/q/s/d to move, e to exit)");
        } else {
            coin.process(&mut score, player.clone(), WIDTH, HEIGHT);
            // enemy.process(player.clone(), WIDTH, HEIGHT);
        }
    }

    Ok(())
}
