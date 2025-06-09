use_bpm 120

amp_beat = 0.8
amp_snare = 0.4
amp_hat = 0.5
amp_bg_synth = 0.6
amp_chord1st_synth = 0.5
amp_chord2nd_synth = 0.3

live_loop :met do
  sleep 1
end

live_loop :beat, sync: :met do
  sample :bd_klub, amp: amp_beat
  sleep 1
end

live_loop :snare, sync: :met do
  sleep 2
  with_fx :echo do
    with_fx :bitcrusher, sample_rate: 8000 do
      sample :drum_splash_hard, sustain: 0.1, release: 0.05, amp: amp_snare
    end
    sleep 6
  end
end

live_loop :hat, sync: :met do
  hit = "-xx-x-xx-x-xx-x-".ring
  16.times do
    with_fx :bitcrusher, sample_rate: 4000 do
      sample :hat_bdu, amp: amp_hat if hit.tick == "x"
    end
    sleep 0.5
  end
end


live_loop :bg_synth, sync: :met do
  use_synth :prophet
  note_list = [:A1, :D1].ring
  
  with_fx :lpf, cutoff: 60 do
    play note_list.tick, sustain: 8, release: 0, amp: amp_bg_synth
  end
  sleep 8
end

live_loop :chord1st_synth, sync: :met do
  use_synth :supersaw
  note_list = [:A3, :D4].ring
  with_fx :reverb, room: 0.9, mix: 0.7 do
    with_fx :ixi_techno, phase: 0.5, cutoff_min: 60, cutoff_max: 80 do
      play_chord chord(note_list.tick(:chord1st_1), :major7), attack: 1, sustain: 2, release: 2, amp: amp_chord1st_synth
    end
  end
  sleep 6
  
  
  with_fx :ixi_techno, phase: 0.25, cutoff_min: 60, cutoff_max: 100 do
    play_chord chord(note_list.tick(:chord1st_2), :major7), sustain: 2, release: 0, amp: amp_chord1st_synth
  end
  sleep 2
end

live_loop :chord2nd_synth, sync: :met do
  use_synth :supersaw
  note_list = [:A4, :D5].ring
  with_fx :reverb, room: 0.9, mix: 0.7 do
    with_fx :ixi_techno, phase: 8, cutoff_min: 100, cutoff_max: 120 do
      play_chord chord(note_list.tick, :major7), attack: 2, sustain: 4, release: 2, amp: amp_chord2nd_synth
    end
  end
  sleep 8
end

# A C# E G# A G# E A
# B D F# A G# - A B


