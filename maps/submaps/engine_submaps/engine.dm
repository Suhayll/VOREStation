// This causes engine maps to get 'checked' and compiled, when undergoing a unit test.
// This is so Travis can validate PoIs, and ensure future changes don't break PoIs, as PoIs are loaded at runtime and the compiler can't catch errors.
// When adding a new engine, please add it to this list.
#if MAP_TEST
#include "engine_rust.dmm"
#include "engine_singulo.dmm"
#include "engine_sme.dmm"
#endif

/datum/map_template/engine
	name = "Engine Content"
	desc = "It would be boring to have the same engine every day right?"
	// annihilate = TRUE - Would wipe out in a rectangular area unfortunately
	allow_duplicates = FALSE

/datum/map_template/engine/rust
	name = "R-UST Engine"
	desc = "R-UST Fusion Tokamak Engine"
	mappath = 'maps/submaps/engine_submaps/engine_rust.dmm'

/datum/map_template/engine/singulo
	name = "Singularity Engine"
	desc = "Lord Singuloth"
	mappath = 'maps/submaps/engine_submaps/engine_singulo.dmm'

/datum/map_template/engine/supermatter
	name = "Supermatter Engine"
	desc = "Old Faithful Supermatter"
	mappath = 'maps/submaps/engine_submaps/engine_sme.dmm'


// Landmark for where to load in the engine on permament map
/obj/effect/landmark/engine_loader
	name = "Engine Loader"

/obj/effect/landmark/engine_loader/initialize()
	var/list/engine_types = list()
	for(var/map in map_templates)
		var/datum/map_template/engine/MT = map_templates[map]
		if(istype(MT))
			engine_types += MT

	var/datum/map_template/engine/chosen_type = pick(engine_types)
	// TESTING - RUST
	chosen_type = map_templates["R-UST Engine"]
	admin_notice("<span class='danger'>Chose Engine Type: [chosen_type.name]</span>", R_DEBUG)
	var/turf/T = loc
	. = ..()
	spawn(5 SECONDS)
		chosen_type.load(T)
	return ..()
