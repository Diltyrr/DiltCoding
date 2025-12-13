import { useBackend } from 'tgui/backend';
import { Box, Section, ProgressBar, Button, Stack } from 'tgui-core/components';

interface GeoTurbineInletData {
  pressure_kpa: number;
  max_pressure_kpa: number;
  valve_lps: number;
  max_valve_lps: number;
}

export const GeoTurbineInlet = () => {
  const { act, data } = useBackend<GeoTurbineInletData>();

  const pressure = data.pressure_kpa ?? 0;
  const pressureMax = data.max_pressure_kpa ?? 1000;
  const valve = data.valve_lps ?? 0;
  const valveMax = data.max_valve_lps ?? 100;

  const pressurePct = Math.max(0, Math.min(100, (pressure / pressureMax) * 100));
  const valvePct = Math.max(0, Math.min(100, (valve / valveMax) * 100));

  const adjustSteps = [-10, -5, -1, +1, +5, +10];

  const barColor = (pct: number) => {
    if (pct < 50) return 'good';     // green
    if (pct < 80) return 'average';  // amber
    return 'bad';                    // red
  };

  return (
    <Box>
      <Section title="Turbine Inlet Control">
        <Stack vertical>
          <Stack.Item>
            <b>Pressure:</b> {pressure.toFixed(1)} kPa
            <ProgressBar
              value={pressurePct}
              minValue={0}
              maxValue={100}
              color={barColor(pressurePct)}
            />
          </Stack.Item>

          <Stack.Item>
            <b>Valve setting:</b> {valve} L/s
            <ProgressBar
              value={valvePct}
              minValue={0}
              maxValue={100}
              color={barColor(valvePct)}
            />
          </Stack.Item>

          <Stack.Item>
            <b>Adjust valve:</b>
            <Box textAlign="center">
              {adjustSteps.map((n) => (
                <Button key={n} onClick={() => act('adjust_valve', { amount: n })}>
                  {n > 0 ? `+${n}` : n}
                </Button>
              ))}
            </Box>
          </Stack.Item>
        </Stack>
      </Section>
    </Box>
  );
};
