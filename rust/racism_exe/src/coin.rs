use rand::Rng;

use crate::{miscellaneous::Collapse, player::Player};

#[derive(Debug, Clone)]
pub struct Coin {
	pub x: u32,
	pub y: u32,
	pub char: String,
}

impl Default for Coin {
	fn default() -> Self {
		Self {
			x: 0,
			y: 0,
			char: "$".to_string(),
		}
	}
}

impl Coin {
	pub fn tp(&mut self, width: u32, height: u32) {
		self.x = rand::rng().random_range(1..width-2);
		self.y = rand::rng().random_range(1..height-2);
	}

	pub fn process(&mut self, score: &mut u32, player: Player, width: u32, height: u32) {
		if self.check(player) {
			*score += 1;
			self.tp(width, height);
		}
	}
}

impl Collapse for Coin {
    fn check(&self, player: crate::player::Player) -> bool {
        player.x == self.x && player.y == self.y
    }
}