use crate::miscellaneous::{Entity, FineIllDoItMyselfResult};

#[derive(Debug, Clone)]
pub struct Player {
	pub x: u32,
	pub y: u32,
	pub char: String,
}

impl Default for Player {
	fn default() -> Self {
		Self {
			x: 1,
			y: 1,
			char: "☻".to_string(),
		}
	}
}

impl Player {

	pub fn motion(&mut self, command: String, width: u32, height: u32) -> FineIllDoItMyselfResult {
		if command == *"z\n" {
			self.up();
		} else if command == *"s\n" {
		    self.down(height);
		} else if command == *"q\n" {
		    self.left();
		} else if command == *"d\n" {
		    self.right(width);
		} else {
			return FineIllDoItMyselfResult::Err;
		}
		FineIllDoItMyselfResult::Ok
	}
}

impl Entity for Player {
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