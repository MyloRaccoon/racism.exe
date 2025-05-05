use crate::{miscellaneous::Entity, player::Player};

#[derive(Debug, Clone)]
pub struct Enemy {
	pub x: u32,
	pub y: u32,
	can_move: bool,
	pub char: String,
}

impl Enemy {
	pub fn new(width: u32, height: u32) -> Self {
		Self {
			x: width-2,
			y: height-2,
			can_move: false,
			char: "☺".to_string(),
		}
	}

	pub fn is_colliding_player(self, player: Player) -> bool {
		let dist_x = (self.x as i32 - player.x as i32).abs();
		let dist_y = (self.y as i32 - player.y as i32).abs();
		dist_x <= 1 && dist_y <= 1 
	}

	pub fn process(&mut self, player: Player, width: u32, height: u32) {
		if self.can_move {
			self.can_move = false;
			let dist_x = (self.x as i32 - player.x as i32).abs();
			let dist_y = (self.y as i32 - player.y as i32).abs();
			if dist_x >= dist_y {
				if self.x > player.x {
					self.left();
				} else {
					self.right(width);
				}
			} else {
				if self.y > player.y {
					self.up();
				} else {
					self.down(height);
				}
			}
		} else {
			self.can_move = true;
		}
	}
}

impl Entity for Enemy {
    fn up(&mut self) {
        if self.y > 1 {
        	self.y -= 1;
        }
    }

    fn down(&mut self, height: u32) {
        if self.y < height - 2 {
        	self.y += 1;
        }
    }

    fn right(&mut self, width: u32) {
    	if self.x < width - 2 {
    		self.x += 1;
    	}
    }

    fn left(&mut self) {
        if self.x > 1 {
        	self.x -= 1;
        }
    }
}