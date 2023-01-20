use bevy::prelude::*;
use bevy_rapier2d::prelude::*;

use crate::{
    c_event::{generate_event, EventSink},
    c_tank::{Bullet, Tank},
    CCollider, CollisionType,
};

pub fn radar_physics(
    rapier_context: Res<RapierContext>,
    mut contact_events: EventReader<CollisionEvent>,
    mut query_tank: Query<(Entity, &Tank, &mut EventSink, &Transform)>,
    query_bullet: Query<&Bullet>,
    query_collider: Query<(&CCollider, &Transform, Option<&Velocity>)>,
) {
    for contact_event in contact_events.iter() {
        for (tank_entity, tank, mut event_sink, tank_transform) in &mut query_tank {
            // let radar = query_radar.get(tank.radar).unwrap();

            if let CollisionEvent::Started(collision_entity_1, collision_entity_2, _event_flag) =
                contact_event
            {
                if collision_entity_1 == &tank.radar && *collision_entity_2 != tank_entity {
                    if rapier_context.intersection_pair(*collision_entity_1, *collision_entity_2)
                        == Some(true)
                    {
                        let (collider, scanned_entity_transform, scanned_entity_velocity) =
                            query_collider.get(*collision_entity_2).unwrap();
                        // info!("{:?} {:?}", tank_entity, state.tick);
                        info!(
                            "Tank Got Scan:{:?} Radar:{:?} Other:{:?}",
                            tank_entity, tank.radar, collision_entity_2
                        );

                        scan(
                            &mut event_sink,
                            &tank_entity,
                            tank_transform,
                            collision_entity_2,
                            scanned_entity_transform,
                            scanned_entity_velocity,
                            &collider.collision_type,
                            &query_bullet,
                        );
                    }
                } else if collision_entity_2 == &tank.radar && *collision_entity_1 != tank_entity {
                    if rapier_context.intersection_pair(*collision_entity_1, *collision_entity_2)
                        == Some(true)
                    {
                        let (collider, collider_transform, velocity) =
                            query_collider.get(*collision_entity_1).unwrap();
                        // info!("{:?} {:?}", tank_entity, state.tick);
                        info!(
                            "Tank Got Scan:{:?} Radar:{:?} Other:{:?}",
                            tank_entity, tank.radar, collision_entity_1
                        );

                        scan(
                            &mut event_sink,
                            &tank_entity,
                            tank_transform,
                            collision_entity_1,
                            collider_transform,
                            velocity,
                            &collider.collision_type,
                            &query_bullet,
                        );
                    }
                }
            }
        }
    }
}

fn scan(
    event_sink: &mut EventSink,
    tank_entity: &Entity,
    _tank_transform: &Transform,
    scanned_entity: &Entity,
    scanned_entity_transform: &Transform,
    scanned_entity_velocity: Option<&Velocity>,
    collision_type: &CollisionType,
    query_bullet: &Query<&Bullet>,
) {
    if *collision_type == CollisionType::Bullet {
        let bullet = query_bullet.get(*scanned_entity).unwrap();

        if bullet.tank == *tank_entity {
            return;
        }
    }
    info!("SCANNED {:?} of type {:?}", scanned_entity, collision_type);

    // let v = t2.rotation * Vec3::Y;

    // let zero = Velocity::zero();

    // let vel = match t2_velocity {
    //     Some(x) => x,
    //     None => &zero,
    // };

    // event_sink.queue.push(Event {
    //     event_type: "scan".to_string(),
    //     info: json!({
    //         "collision_type": format!("{:?}", collision_type),
    //         "entity": b,
    //         "transform": {
    //             "x": t2.translation.x,
    //             "y": t2.translation.y,
    //             "rotation": v.y.atan2(v.x),
    //         },
    //         "velocity": {
    //             "linvel": {
    //                 "x": vel.linvel.x,
    //                 "y": vel.linvel.y
    //             },
    //             "angvel": vel.angvel
    //         }
    //     }),
    // });

    generate_event(
        event_sink,
        scanned_entity,
        scanned_entity_transform,
        scanned_entity_velocity,
        collision_type,
    );
}
