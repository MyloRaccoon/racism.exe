use crate::player::Player;

pub trait Entity {
	fn up(&mut self);
	fn down(&mut self, height: u32);
	fn right(&mut self, width: u32);
	fn left(&mut self);
}

pub trait Collapse {
	fn check(&self, player: Player) -> bool;
} 

#[derive(Debug, Eq, PartialEq)]
pub enum FineIllDoItMyselfResult {
    Ok,
    Err,
}