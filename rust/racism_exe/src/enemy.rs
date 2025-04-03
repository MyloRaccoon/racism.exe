use crate::{miscellaneous::Entity, player::Player};

#[derive(Debug, Clone)]
pub struct Enemy {
	pub x: u32,
	pub y: u32,
	pub char: String,
}

impl Enemy {
	pub fn new(width: u32, height: u32) -> Self {
		Self {
			x: width-2,
			y: height-2,
			char: "E".to_string(),
		}
	}

	pub fn process(&mut self, player: Player, width: u32, height: u32) {
		let dist_x = i32::abs((self.x - player.x).try_into().unwrap());
		let dist_y = i32::abs((self.x - player.x).try_into().unwrap());
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